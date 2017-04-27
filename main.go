package main

import (
	"flag"
	"github.com/xeipuuv/gojsonschema"
	"log"
	"os"
	"strings"
)

// CLI arguments
var schPath = flag.String("schema-path", "/schema.json", "specify the full path for the schema file")
var jsPath = flag.String("json-path", "/test.json", "specify the full path for the json file to test against the schema")

func main() {
	var p string = ""
	var err error
	// if the full path to files is given read it
	if len(os.Args) > 1 {
		flag.Parse()
		log.Printf("[Debug] read: schema = %s, json = %s\n", *schPath, *jsPath)
	} else {
		// otherwise assume it is in the current directory
		log.Println("[Debug] Reading current path")
		p, err = os.Getwd()
		if err != nil {
			log.Fatal("[Fatal] Could not get current directory")
			return
		}
	}
	// normalize files paths
	*schPath = strings.Join([]string{"file://", p, *schPath}, "")
	*jsPath = strings.Join([]string{"file://", p, *jsPath}, "")
	// compare against schema
	schemaLoad := gojsonschema.NewReferenceLoader(*schPath)
	jsonDocument := gojsonschema.NewReferenceLoader(*jsPath)
	log.Println("[Debug] Checking document against schema")
	// give the results of the comparison
	result, err := gojsonschema.Validate(schemaLoad, jsonDocument)
	if err != nil {
		log.Fatal("[Fatal] ", err)
		return
	}
	if result.Valid() {
		log.Println("Valid document")
	} else {
		log.Println("Invalid document")
		for _, desc := range result.Errors() {
			log.Println("[Error] ", desc)
		}
	}
}
