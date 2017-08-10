# allow for custom input blocks
#
# Example Puppet Code:
# ::nxlog::config::input { 'sawyer':
#   output_module  => 'im_msvistalog',
#   input_execs    => [
#     'delete($Keywords)',
#     '$raw_event = to_json()',
#   ],
# }
#
# Resulting output:
#
define nxlog::config::input (
  $conf_dir        = lookup('nxlog::conf_dir'),
  $conf_file       = lookup('nxlog::conf_file'),
  $input_execs     = lookup('nxlog::input_execs'),
  $input_file_path = lookup('nxlog::input_file_path'),
  $input_module    = lookup('nxlog::input_module'),
  $input_type      = lookup('nxlog::input_type'),
  $order_input     = lookup('nxlog::order_input'),
  ) {

  require ::nxlog

  concat::fragment { "input_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_input,
    content => template('nxlog/input.erb'),
  }
}
