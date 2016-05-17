import "phoenix_html"
import "bootstrap-sass"
// import "jquery" // jquery is imported by default
import initialize_plugins from "./admin/bootstrap_init"

$(function(){
  initialize_plugins();
  console.log('admin ready');
})
