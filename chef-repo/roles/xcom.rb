name "xcom"
description "xcom role"
run_list(
   "recipe[jenkins]",
   "recipe[nexus]"
)
#we need ant and java, try java-1.6.0-openjdk-devel which is an rpm for centos that includes compiler
default_attributes()
override_attributes()
