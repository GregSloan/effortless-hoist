# Effortless-Hoist

[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

A cookbook to help automate "attribute hoisting" when using Chef with Policyfiles and the Effortless pattern.
The `poise-hoist` cookbook (https://github.com/poise/poise-hoist), on which this  cookbook is based, does this using policy groups, however policy groups are not available when distributing Chef Infra Client and Policyfiles via the Effortless pattern. This cookbook instead keys off of an attribute that can be configured on the node using Habitat configuration injection mechanism (e.g. user.toml)

Attribute hoisting is a way to attributes in a policy to
allow similar settings to environment-level attributes in a pre-Policyfile
workflow. Just put the desired attributes under a top-level key to match the desired enviornment name
and add `effortless-hoist` either to your run list or to your cookbook dependencies. Then add an `enviornment_id` attribute via a Habitat configuration file with the matching environment name at runtime.

## Quick Start

In your Policyfile:

```ruby
name 'myapp'

run_list 'effortless-hoist', 'myapp'

# Default value for all groups.
default['myapp']['debug_mode'] = true

# Per-environment values, will be hoisted on top of the default above.
default['staging']['myapp']['debug_mode'] = 'extra_verbose'
default['prod']['myapp']['debug_mode'] = false
```

and then in your recipe code:

```ruby
some_resource 'name' do
  debug_mode node['myapp']['debug_mode']
end
```

This automatically hoists up policy attributes set under a top-level key
matching the name of the policy group of the current node.

Finally, on the node, create a .toml file:

```toml
[attributes]
environment_id = 'staging'
```

Apply that configuration to the service group of your effortless infra package.

Either save the above toml as `environment.toml`, then execute:

`hab config apply my_effortless_app.default $(date +%s) /path/to/environment.toml`

OR save the above toml as `/hab/user/my_effortless_app/user.toml`

This can be done before the `my_effortless_app` habitat svc is loaded on the node, ensuring the environment is set on first run.

## Requirements

Chef 12.2 or newer is required.

## Use With Test Kitchen

Use `kitchen-habitat` (https://github.com/test-kitchen/kitchen-habitat) to test the built packages

## Environment Shim

!!NOT YET IMPLEMENTED IN ENVIRONMENT-HOIST!!

For older cookbooks still expecting to use `node.chef_environment`, by default
that method will be patched to return the policy group label instead. This can
be disabled by setting `node['environment-hoist']['hoist_chef_environment'] = false`.

## License

Copyright for portions of project Environment-Hoist are held by Noah Kantrowitz, 2016-2017 as part of project Poise-Hoist. All other copyright for project Environment-Hoist are held by Gregory Sloan, 2019-2020

Environment-Hoist
Copyright 2019-2020, Gregory Sloan

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
