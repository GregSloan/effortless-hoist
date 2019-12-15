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

require 'environment_hoist'
# Try to hoist as early as possible.
EnvironmentHoist.hoist!(Chef.node) if defined?(Chef.node)
