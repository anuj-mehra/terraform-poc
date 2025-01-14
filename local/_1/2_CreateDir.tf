resource "local_file" "create_folder" {

    filename="/Users/anujmehra/git/terraform-poc/output/local1/.keep"
    content  = "" # Placeholder file to ensure the folder is created
    directory_permission = "0755"
}