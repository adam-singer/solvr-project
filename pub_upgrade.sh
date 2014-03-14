projects=(common types ast parser type_checker kernel)

foreach in projects
pushd common
    pub upgrade
popd

