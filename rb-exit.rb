require 'gtk3'

class ButtonWindow < Gtk::Window
  def initialize
    super
    set_title 'Log out? Choose an option:'
    set_border_width 15
    set_default_size 500, 60
    set_window_position Gtk::WindowPosition::CENTER

    hbox = Gtk::ButtonBox.new(:horizontal)
    add(hbox)

    button = Gtk::Button.new(label: 'Cancel')
    button.signal_connect('clicked') { on_cancel_clicked }
    hbox.pack_start(button)

    button = Gtk::Button.new(mnemonic: '_Log out')
    button.signal_connect('clicked') { on_log_out_clicked }
    hbox.pack_start(button)

    button = Gtk::Button.new(mnemonic: '_Suspend')
    button.signal_connect('clicked') { on_suspend_clicked }
    hbox.pack_start(button)

    button = Gtk::Button.new(mnemonic: '_Reboot')
    button.signal_connect('clicked') { on_reboot_clicked }
    hbox.pack_start(button)
    
    button = Gtk::Button.new(mnemonic: '_Power off')
    button.signal_connect('clicked') { on_shutdown_clicked }
    hbox.pack_start(button)
  end

  def on_cancel_clicked
    self.destroy
  end  
  
  def on_log_out_clicked
    self.set_title 'Exiting Openbox, please standby...'
    self.set_sensitive(false)
    system("openbox --exit")
  end

  def on_suspend_clicked
    self.set_title 'Suspending, please standby...'
    self.set_sensitive(false)
    system("systemctl suspend")
    Gtk.main_quit
  end
  
  def on_reboot_clicked
    self.set_title 'Rebooting, please standby...'
    self.set_sensitive(false)
    system("systemctl reboot")
  end
  
  def on_shutdown_clicked
    self.set_title 'Shutting down, please standby...'
    self.set_sensitive(false)
    system("systemctl poweroff")
  end
end

win = ButtonWindow.new
win.signal_connect('destroy') { Gtk.main_quit }
win.show_all
Gtk.main
