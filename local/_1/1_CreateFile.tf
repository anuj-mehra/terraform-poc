resource "local_file" "name1" {

    filename="/Users/anujmehra/git/terraform-poc/output/local/name1.txt"
    content="this is my first terraform file"
    directory_permission = "0755"
    file_permission="0755"
}

resource "local_file" "name2" {

    filename="/Users/anujmehra/git/terraform-poc/output/local/name2.txt"
    content="this is my first terraform file"
    directory_permission = "0755"
    file_permission="0755"
}