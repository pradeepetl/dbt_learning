# # models/marts/fct_sales_summary_py.py

import pandas as pd

def model(dbt, session):
    """
    A dbt Python model that calculates profit, margin, and aggregates sales
    by region and category.
    """

    # Reference to staging SQL model
    stg_sales_df = dbt.ref("stg_sales")

    # Convert it into a pandas or spark dataframe (depending on your engine)
    df = stg_sales_df.to_pandas()

    # Filter data for valid rows (profit > 0)
    df = df[df["SALES"] > 0]

    # Derive profit and margin
    df["profit"] = df["SALES"] - df["COST"]
    df["margin"] = (df["profit"] / df["SALES"]).round(2)

    # Aggregate
    agg_df = (
        df.groupby(["REGION", "CATEGORY"])
        .agg(
            total_sales=("SALES", "sum"),
            total_cost=("COST", "sum"),
            total_profit=("PROFIT", "sum"),
            avg_margin=("MARGIN", "mean")
        )
        .reset_index()
    )

    return agg_df



# import pandas as pd

# def model(dbt, session):
#     df = dbt.ref("stg_sales")

#     # Temporarily reduce rows to inspect structure
#     #print(df)
#     return df

