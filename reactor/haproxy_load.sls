slack_state:
  local.state.sls:
    - tgt: saltmaster
    - arg: 
      - slack.newweb

activate_web:
  local.state.sls:
    - tgt: VMHOST
    - arg: 
      - startweb

orchestrate_run:
  runner.state.orchestrate:
    - mods: orch.stackdeploy
