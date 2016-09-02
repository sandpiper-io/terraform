variable "carina_cluster_host" {
}
variable "carina_cluster_cert_path" {
}
variable "cluster_name" {
  default = "mysql_example"
}
variable "network_name" {
  default = "mynetwork"
}
variable "mysql_root_password" {
  default = "root-password"
}
variable "mysql_database" {
  default = "guestbook"
}
variable "mysql_user" {
  default = "guestbook-user"
}
variable "mysql_password" {
  default = "guestbook-user-password"
}
variable "mysql_host" {
  default = "mysql"
}
variable "mysql_port" {
  default = "3306"
}
