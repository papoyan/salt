dev:
  # See the following article for the naming convention.
  #
  # https://wiki.nuancehce.com/display/HD/Hostname+Convention

  # TODO - Adding Zenoss although it's suppose to be the staging environment. Eventually, the host should be re-built
  'G@virtual:VirtualBox or E@docker or E@jenkins* or E@nd.*-d.*  or E@sv.*-vl.* or E@sv.*-d.* or E@ndinf-svzen0001 or E@ndmhce-v.* or E@nd.*-sv.*':
    - match: compound
    - roles
