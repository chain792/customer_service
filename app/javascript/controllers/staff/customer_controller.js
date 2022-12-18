import { Controller } from "@hotwired/stimulus"
import jQuery from "jquery"
window.$ = jQuery

// Connects to data-controller="staff--customer"
export default class extends Controller {
  static targets = ["home", "work"]

  initialize() {
    this.toggle_home()
    this.toggle_work()
  }
  toggle_home() {
    const checked = this.homeTarget.checked
    $("fieldset#home-address-fields input").prop("disabled", !checked);
    $("fieldset#home-address-fields select").prop("disabled", !checked);
    $("fieldset#home-address-fields").toggle(checked);
  }
  toggle_work() {
    const checked = this.workTarget.checked
    $("fieldset#work-address-fields input").prop("disabled", !checked);
    $("fieldset#work-address-fields select").prop("disabled", !checked);
    $("fieldset#work-address-fields").toggle(checked);
  }

}
