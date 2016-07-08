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

	h := http.FileServer(http.Dir(folder))
	h = noCache{h}
	panic(http.ListenAndServe(":8080", h))
}

type noCache struct {
	h http.Handler
}

func (nc noCache) ServeHTTP(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Cache-Control", "no-cache, must-revalidate")
	w.Header().Set("Pragma", "no-cache")

	req.Header["If-Modified-Since"] = nil
	nc.h.ServeHTTP(w, req)
}
