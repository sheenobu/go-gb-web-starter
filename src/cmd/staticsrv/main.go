package main

import (
	"demo"
	"fmt"
	"net/http"
)

func main() {
	folder := "./src/www"
	fmt.Printf("listening on http://localhost:8080\n")
	fmt.Printf("calculating the answer for a second: %d\n", demo.TheAnswer)
	fmt.Printf("listening on folder: %s\n", folder)
	panic(http.ListenAndServe(":8080", http.FileServer(http.Dir(folder))))
}
