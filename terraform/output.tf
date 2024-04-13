output "ipv4" {
  value = merge(
    {
      for vm in vsphere_virtual_machine.vm : "${vm.name}-ipv4" => vm.guest_ip_addresses[0]
    },
    {
      for win_vm in vsphere_virtual_machine.win_vm : "${win_vm.name}-ipv4" => win_vm.guest_ip_addresses[0]
    }
  )
}