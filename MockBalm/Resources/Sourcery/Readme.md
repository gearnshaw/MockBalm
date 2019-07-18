# MockBalm Sourcery Usage
## Configuration
Create a yaml file in the route of the project as follows:

```yaml
sources:
  - ./my_main_target_folder
	- ./Pods/MockBalm
templates:
  include:
    - ./Pods/MockBalm/MockBalm/Resources/Sourcery/Templates/Test
output:
  ./my_test_target-folder/generated
```

There is an example file that can be copied in `/Config/.sourcery.yml`

## Usage
Include the MockBalm pod in a project. Then add a run phase to the project to generate mocks when the project builds:
``` bash
“$PODS_ROOT/Sourcery/bin/sourcery”
```

E.g.:

![](Readme/Screenshot%202019-07-17%2020.26.06.png)