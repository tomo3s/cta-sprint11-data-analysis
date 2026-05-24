import sys

from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext

args = getResolvedOptions(sys.argv, ["JOB_NAME", "S3_OUTPUT_PATH"])

sc = SparkContext()
glue_context = GlueContext(sc)
job = Job(glue_context)

job.init(args["JOB_NAME"], args)

datasource = glue_context.create_dynamic_frame.from_options(
    connection_type="mysql",
    connection_options={
        "useConnectionProperties": "true",
        "connectionName": "sales-analytics-rds-connection",
        "dbtable": "sales"
    }
)

glue_context.write_dynamic_frame.from_options(
    frame=datasource,
    connection_type="s3",
    connection_options={
        "path": args["S3_OUTPUT_PATH"]
    },
    format="parquet"
)

job.commit()