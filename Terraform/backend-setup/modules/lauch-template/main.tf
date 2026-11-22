resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Install Docker
    dnf install -y docker

    # Start Docker
    systemctl enable docker
    systemctl start docker

    # Pull application image
    docker pull ${var.docker_image}

    # Run application
    docker run -d \
      --name app \
      -p 8080:80 \
      ${var.docker_image}
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-server"
    }
  }
}