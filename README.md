# Generate self-signed certification
Generate self-signed certificate for development environment purpose

## How to generate
1. Update variables in generate.sh file as needed.
2. Update domains and ip addresses that will be used with the generated certificates
3. Execute generate.sh

## How to use the generated certificate files
1. Ensure the browser of all users has this rootCA in `Trusted Root Certification Authorities` to do this depends on the OS. If you have `certutil` library then simply run below command.
```
certutil -addstore Root RootCA.crt
```
2. Make sure the website properly configure SSL using generated pfx file and specified password. This depends on the platforms.
For instance of .NET with Kestrel, add below to the appsettings.json.
```
"Kestrel": {
    "Endpoints": {
      "Http": {
        "Url": "http://0.0.0.0:5000"
      },
      "Https": {
        "Url": "https://0.0.0.0:5001",
        "Certificate": {
          "Path": "certs/mycert.pfx",
          "Password": "mypassword"
        }
      }
    }
  }
```
