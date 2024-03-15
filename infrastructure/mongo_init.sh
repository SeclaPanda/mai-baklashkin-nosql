#!/bin/bash
sleep 10

mongosh --host 192.168.80.76:27017 <<EOF
  var config = {
    "_id": "mongocluster",
    "members": [{
            "_id": 0,
            "host": "192.168.80.76:27017"
        },
        {
            "_id": 1,
            "host": "192.168.80.76:27018"
        },
        {
            "_id": 2,
            "host": "192.168.80.76:27019"
        }
    ]
  }
  rs.initiate(config);
EOF
