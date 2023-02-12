variable "docker_var" {
    type = map(string)
    default = {
    ami = "ami-00874d747dde814fa"
    ttype = "t2.micro"
    route_table = "0.0.0.0/0"
    zone = "us-east-1a"
    cidr = "10.0.1.0/24"
    }
}