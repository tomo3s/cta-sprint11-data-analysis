# CloudTech Sprint11 - Data Analytics Platform

## Overview

AWS Glue, Athena, and S3 を利用したデータ分析基盤をTerraformで構築しました。

## Architecture

* RDS MySQL
* AWS Glue ETL
* Amazon S3 (Parquet)
* Glue Crawler
* Glue Data Catalog
* Amazon Athena

## Features

* RDSから売上データを抽出
* Parquet形式へ変換
* S3へ保存
* AthenaによるSQL分析

## Notes

QuickSightは任意要件のため未実施。
