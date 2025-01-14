resource "local_file" "name3" {
    filename=var.filename
    content=var.content
    directory_permission = var.directory_permission
    file_permission=var.file_permission
}


