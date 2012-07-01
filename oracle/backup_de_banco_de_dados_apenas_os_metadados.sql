-- Backup de banco de dados apenas os metadados
expdp backup/backup content=metadata_only directory=expdp dumpfile=expdp_metadata.dmp logfile=expdpmetadata.log