# models/marts/fct_sales_summary_py.py

import snowflake.snowpark.functions as F

def model(dbt, session):
    """
    Snowpark dbt model to calculate profit, margin, and aggregates
    by region and category.
    """

    # Reference the SQL staging model
    stg_sales_df = dbt.ref("stg_sales")

    # Convert to Snowpark DataFrame
    df = session.table("demo_db.public.stg_sales")

    # Add profit and margin columns
    df = (
        df.with_column("profit", df["SALES"] - df["COST"])
          .with_column("margin", (df["SALES"] - df["COST"]) / df["SALES"])
    )

    # Filter only rows with positive profit
    df = df.filter(df["profit"] > 0)

    # Aggregate by region and category
    result_df = (
        df.group_by("REGION", "CATEGORY")
          .agg(
              F.sum("SALES").alias("total_sales"),
              F.sum("COST").alias("total_cost"),
              F.sum("profit").alias("total_profit"),
              F.avg("margin").alias("avg_margin")
          )
    )

    return result_df