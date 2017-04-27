# Small program to test a json example against a schema
This program uses `github.com/xeipuuv/gojsonschema` to do the verification. `example` folder contains a working example of a schema and test file. 

## Usage
```sh
make help
```
### Executable
A statically linked EXE of the program. 

### The json files
You can put them in the same folder as the EXE if you don't want to bother. The schema must be then name `schema.json` and the sample `test.json`. If your files are elesewher on the filesystem use the program options below.

### Options
```sh
  -json-path string
      specify the full path for the json file to test against the schema (default "/test.json")
  -schema-path string
      specify the full path for the schema file (default "/schema.json")
```

### Docker
Use the `image` make target to build the image, and the `run` target for the example. 
