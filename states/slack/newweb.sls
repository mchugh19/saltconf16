notify_slack:
  slack.post_message:
    - channel: '#salttest'
    - from_name: 'SaltMaster'
    - message: 'EFHApp loadbalancer experiencing high load. Adding additional web capacity'
    - api_key: KEY-GOES-HERE
