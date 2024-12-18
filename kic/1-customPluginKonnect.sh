export CPID=1cc5ec46-0918-4cbd-b0ad-9d629d93e285
export PAT=$KONNECT_JEROME
https -A bearer \
      -a $PAT \
      eu.api.konghq.com/v2/control-planes/$CPID/core-entities/plugin-schemas\
      lua_schema=@../kong/plugins/add-date-in-response/schema.lua