output "public1a_subnet_id"{
    value= aws_subnet.subnet_pub1a.id
}

output "public1b_subnet_id"{
    value= aws_subnet.subnet_pub1b.id
}

output "priv1a_subnet_id"{
    value= aws_subnet.subnet_priv1a.id
}

output "priv1b_subnet_id"{
    value= aws_subnet.subnet_priv1b.id
}

output "priv2a_subnet_id"{
    value= aws_subnet.subnet_priv2a.id
}

output "priv2b_subnet_id"{
    value= aws_subnet.subnet_priv2b.id
}



output "security_group"{
    value= aws_security_group.mypub_sg.id
}

output "vpc_id"{
    value= aws_vpc.myvpc.id
}