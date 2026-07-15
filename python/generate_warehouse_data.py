import pandas as pd

import random



# -----------------------------

# CONFIG

# -----------------------------

months = list(range(1, 13))



# ~1M rows total (adjusted by seasonality)

rows_per_month = 83333



categories = [

    "Electronics",

    "Clothing",

    "Home",

    "Toys",

    "Books"

]



shifts = [

    "Morning",

    "Mid",

    "Afternoon",

    "Night"

]



pick_missing_error_rate = 0.02

pick_damage_miss_rate = 0.03

pack_ignore_damage_rate = 0.04



order_id = 100000

first_write = True



output_file = "warehouse_12month_1M.csv"



# -----------------------------

# COLUMN NAMES

# -----------------------------

columns = [

    "OrderID",

    "PodID",



    "PickFloor",

    "PickSide",

    "PickStation",

    "PickStationID",



    "PackLine",

    "PackWall",

    "PackStation",

    "PackStationID",



    "Category",

    "ShiftName",

    "OrderMonth",



    "PickStart",

    "PickEnd",

    "PackStart",

    "PackEnd",



    "PickMarksMissingButFound",

    "PickFailsToMarkDamage",



    "PackDetectsDamage",

    "PackIgnoresDamage",



    "RobotDetectsDefect",

    "DefectType"

]



# -----------------------------

# SEASONALITY

# -----------------------------

def season(month):



    if month == 7:

        return 1.4



    elif month == 11:

        return 1.5



    elif month == 12:

        return 1.6



    elif month in [9, 10]:

        return 1.2



    else:

        return 1.0





# -----------------------------

# PICK STATION

# -----------------------------

def pick_station():



    floor = random.randint(1, 4)

    side = random.choice(["E", "W"])

    station = str(random.randint(1, 52)).zfill(2)



    return floor, side, station, f"{floor}{side}{station}"





# -----------------------------

# PACK STATION

# -----------------------------

def pack_station():



    line = str(random.randint(1, 20)).zfill(2)

    wall = random.randint(1, 2)

    station = random.randint(1, 6)



    return line, wall, station, f"L{line}-W{wall}-S{station}"





# -----------------------------

# MAIN LOOP

# -----------------------------

for month in months:



    multiplier = season(month)

    adjusted_rows = int(rows_per_month * multiplier)



    batch = []



    for _ in range(adjusted_rows):



        # ---------------- PICK ----------------

        pf, ps, pst, pid = pick_station()

        lf, lw, lst, lid = pack_station()



        shift = random.choices(

            shifts,

            weights=[0.3, 0.3, 0.2, 0.2]

        )[0]



        pick_start = random.randint(1, 10)

        pick_end = pick_start + random.randint(2, 6)



        pack_start = pick_end + random.randint(1, 3)

        pack_end = pack_start + random.randint(4, 10)



        # ---------------- PICK DEFECTS ----------------

        pick_marks_missing_but_found = int(

            random.random() < pick_missing_error_rate

        )



        pick_fails_to_mark_damage = int(

            random.random() < pick_damage_miss_rate

        )



        # ---------------- PACK DEFECTS ----------------

        pack_detects_damage = int(

            pick_fails_to_mark_damage == 1

        )



        pack_ignores_damage = int(

            pick_fails_to_mark_damage == 1 and

            random.random() < pack_ignore_damage_rate

        )



        # ---------------- ROBOT FINAL CHECK ----------------

        robot_detects_defect = int(

            pick_marks_missing_but_found == 1 or

            pick_fails_to_mark_damage == 1 or

            pack_ignores_damage == 1

        )



        # ---------------- DEFECT TYPE ----------------

        if pick_marks_missing_but_found:



            defect_type = "False Missing Claim"



        elif (

            pick_fails_to_mark_damage and

            pack_ignores_damage

        ):



            defect_type = "Damaged Item Packed"



        elif pick_fails_to_mark_damage:



            defect_type = "Undetected Damage at Pick"



        elif pack_detects_damage:



            defect_type = "Pack Stage Damage Detection"



        else:



            defect_type = "None"



        batch.append([

            f"O{order_id}",

            f"POD{random.randint(1,40)}",



            pf,

            ps,

            pst,

            pid,



            lf,

            lw,

            lst,

            lid,



            random.choice(categories),

            shift,

            month,



            pick_start,

            pick_end,

            pack_start,

            pack_end,



            pick_marks_missing_but_found,

            pick_fails_to_mark_damage,



            pack_detects_damage,

            pack_ignores_damage,



            robot_detects_defect,

            defect_type

        ])



        order_id += 1



        # End of row creation loop





    # -----------------------------

    # SAVE MONTHLY CHUNK

    # -----------------------------

    df = pd.DataFrame(
        batch,
        columns=columns
    )




    df.to_csv(
        output_file,
        mode="a",
        header=first_write,
        index=False
    )

    first_write = False

print("DONE:", output_file)





# -----------------------------

# DATA TYPE VALIDATION

# -----------------------------

df["PickMarksMissingButFound"] = (

    df["PickMarksMissingButFound"]

    .astype(int)
)
df["PickFailsToMarkDamage"] = (

    df["PickFailsToMarkDamage"]

    .astype(int)

)



df["PackDetectsDamage"] = (

    df["PackDetectsDamage"]

    .astype(int)

)



df["PackIgnoresDamage"] = (

    df["PackIgnoresDamage"]

    .astype(int)

)



df["RobotDetectsDefect"] = (

    df["RobotDetectsDefect"]

    .astype(int)

)