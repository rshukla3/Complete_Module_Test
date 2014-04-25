cd I:/Xilinx_Projects/Complete_Module_Test/complete_module_test
if { [ catch { xload xmp complete_module_test.xmp } result ] } {
  exit 10
}
xset intstyle default
save proj
exit 0
