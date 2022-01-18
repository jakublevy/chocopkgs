

# xh
`xh` is a friendly and fast tool for sending HTTP requests. It reimplements as much as possible of HTTPie's excellent design, with a focus on improved performance.

## Examples
```
# Send a GET request
xh httpbin.org/json

# Send a POST request with body {"name": "john", "age": 27}
xh httpbin.org/post name=john age:=27

# Send a GET request with querystring id=5&sort=true
xh get httpbin.org/json id==5 sort==true

# Send a GET request and include a header named x-api-key with value 12345
xh get httpbin.org/json x-api-key:12345

# Send a PUT request and pipe the result to less
xh put httpbin.org/put id:=49 age:=25 | less

# Download and save to res.json
xh -d httpbin.org/json -o res.json

# Make a request with a custom user agent
xh httpbin.org/get user-agent:foobar
```

### For more information about xh see [README.md](https://github.com/ducaale/xh/blob/master/README.md).