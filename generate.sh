CN="MyCN.Dev"
OUTPUT_DIR="./output"
OUTPUT_FILENAME_BASE="mycert.dev"

mkdir $OUTPUT_DIR || true

# gen rootca
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout $OUTPUT_DIR/RootCA.key -out $OUTPUT_DIR/RootCA.pem -subj "/C=US/CN=$CN"
openssl x509 -outform pem -in $OUTPUT_DIR/RootCA.pem -out $OUTPUT_DIR/RootCA.crt

# gen cert for specific domains
openssl req -new -nodes -newkey rsa:2048 -keyout $OUTPUT_DIR/$OUTPUT_FILENAME_BASE.key -out $OUTPUT_DIR/$OUTPUT_FILENAME_BASE.csr -subj "/C=US/ST=YourState/L=YourCity/O=Example-Certificates/CN=$CN"
openssl x509 -req -sha256 -days 1024 -in $OUTPUT_DIR/$OUTPUT_FILENAME_BASE.csr -CA $OUTPUT_DIR/RootCA.pem -CAkey $OUTPUT_DIR/RootCA.key -CAcreateserial -extfile domains.ext -out $OUTPUT_DIR/$OUTPUT_FILENAME_BASE.crt

# gen pfx
openssl pkcs12 -export -out $OUTPUT_DIR/$OUTPUT_FILENAME_BASE.pfx -inkey $OUTPUT_DIR/$OUTPUT_FILENAME_BASE.key -in $OUTPUT_DIR/$OUTPUT_FILENAME_BASE.crt
