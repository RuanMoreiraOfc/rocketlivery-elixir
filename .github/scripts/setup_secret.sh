# "Start Example Setup"
cp config/config.secrets.example config/.t;
# "Guardian | Rename `my_app_name` key"
sed -i 's|my_app_name|rocketlivery|g' config/.t;
# "Guardian | Rename `my_module_using_guardian` key"
sed -i 's|my_module_using_guardian|RocketliveryWeb.Auth.Guardian|' config/.t;
# "Guardian | Add `secret` key"
sed -i "s|secret_key:\ \".*\"|secret_key:\ \"$GUARDIAN_SECRET\"|" config/.t;
# "[DEGUB]"
cat config/.t
# "Finish Example Setup"
mv config/.t config/config.secrets.exs