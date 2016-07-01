package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Printf("listening on http://localhost:8080\n")
	panic(http.ListenAndServe(":8080", http.FileServer(http.Dir("./src/www/"))))
}
