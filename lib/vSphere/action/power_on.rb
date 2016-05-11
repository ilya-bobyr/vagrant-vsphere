require 'rbvmomi'
require 'i18n'
require 'vSphere/util/vim_helpers'
require 'vSphere/util/machine_helpers'
require 'vSphere/util/vm_helpers'

module VagrantPlugins
  module VSphere
    module Action
      class PowerOn
        include Util::VimHelpers
        include Util::VmHelpers
        include Util::MachineHelpers

        def initialize(app, _env)
          @app = app
        end

        def call(env)
          vm = get_vm_by_uuid env[:vsphere].connection, env[:machine]

          env[:ui].info I18n.t('vsphere.power_on_vm')
          power_on_vm(vm)

          # wait for SSH to be available
          wait_for_ssh env

          @app.call env
        end
      end
    end
  end
end
