#!/bin/bash

docker run --rm -v ragflow_redis_data:/data -v $(pwd)/backup:/backup busybox tar czvf /backup/redis_data_$(date +%F).tar.gz -C /data .