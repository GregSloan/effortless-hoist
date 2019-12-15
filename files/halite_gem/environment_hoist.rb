#
# Copyright for portions of project Environment-Hoist are held by 
# Noah Kantrowitz, 2016-2017 as part of project Poise-Hoist. 
# All other copyright for project Environment-Hoist are held by Gregory Sloan, 2019-2020
#
# Copyright 2019-2020, Gregory Sloan
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/mixin/deep_merge'



# Helpers to hoist group-level attributes from a Policyfile.
#
# @since 1.0.0
module EnvironmentHoist


  autoload :VERSION, 'environment_hoist/version'

  # Run the attribute hoist process.
  #
  # @param node [Chef::Node] Node object to modify.
  # @return [void]
  def self.hoist!(node)
    return unless node['environment_id']

    env = node['environment_id']
    Chef::Log.debug("Running attribute Hoist for environmet #{env}")

    # Hoist away, mateys!
    Chef::Mixin::DeepMerge.hash_only_merge!(node.role_default, node.role_default[env]) if node.role_default.include?(env)
    Chef::Mixin::DeepMerge.hash_only_merge!(node.role_override, node.role_override[env]) if node.role_override.include?(env)
    
  end


end
