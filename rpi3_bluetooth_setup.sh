
#!/bin/bash
mac_address='A0:E9:DB:08:C1:BF'
mac_address_=$(echo "$mac_address" | tr ':' '_')

coproc bluetoothctl
echo -e 'power on' >&${COPROC[1]}

echo -e 'agent on' >&${COPROC[1]}

echo -e 'default-agent' >&${COPROC[1]}

sudo killall bluealsa
pulseaudio --start

echo -e 'pair '$mac_address >&${COPROC[1]}
echo -e 'trust '$mac_address >&${COPROC[1]}
echo -e 'connect '$mac_address >&${COPROC[1]}

pacmd set-card-profile bluez_card.$mac_address_ a2dp_sink
pacmd set-default-sink bluez_sink.$mac_address_.a2dp_sink

sudo hcitool cmd 0x3F 0x01C 0x01 0x02 0x00 0x01 0x01

pacmd set-card-profile bluez_card.$mac_address_ headset_head_unit

pacmd set-default-sink bluez_sink.$mac_address_.headset_head_unit
pacmd set-default-source bluez_source.$mac_address_.headset_head_unit

