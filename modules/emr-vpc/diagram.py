#!/bin/env python3

from diagrams import Cluster, Diagram, Edge
from diagrams.aws.storage import S3
from diagrams.aws.security import IAM
from diagrams.custom import Custom
from diagrams.aws.compute import EC2ElasticIpAddress
from diagrams.aws.network import PrivateSubnet, NATGateway, InternetGateway, Endpoint
from diagrams.aws.security import Shield
from diagrams.onprem.analytics import Databricks

diagram_attr = {
    "pad": "0.5"
}

with Diagram("Tecton EMR VPC Deployment", graph_attr=diagram_attr, filename="diagram"):
    tecton = Edge(Custom("Tecton", "../../resources/tecton-red-on-blue.png"))

    with Cluster("Customer owned AWS account"):
        S3("Tecton S3 bucket")
        with Cluster("IAM"):
            # common
            ca_iam_role = IAM("Cross-account role")
            IAM("Spot service-linked role")
            IAM("EKS Nodegroup service-linked role")
            # emr/iam
            IAM("Spark role")

            with Cluster("IAM - EKS cluster roles"):
                IAM("EKS management role")
                IAM("EKS node role")

        with Cluster("Tecton VPC"):
            with Cluster("Tecton Public Subnet (1/AZ)"):
                public_subnet = PrivateSubnet("Public")
            with Cluster("Tecton Private Subnet (1/AZ)"):
                private_subnet = PrivateSubnet("Private")
            with Cluster("EMR Private Subnet (1/AZ)"):
                emr_private_subnet = PrivateSubnet("EMR Private")

            vpc_endpoint_dynamo = Endpoint("DynamoDB VPC Endpoint")
            vpc_endpoint_s3 = Endpoint("S3 VPC Endpoint")

            private_subnet >> vpc_endpoint_dynamo << emr_private_subnet
            private_subnet >> vpc_endpoint_s3 << emr_private_subnet

            sg_rds = Shield("RDS security group")
            sg_control = Shield("EKS control security group")
            sg_node = Shield("EKS node security group")
            sg_control >> sg_node >> sg_control
            sg_node >> sg_rds
            sg_vpc_endpoint = Shield("VPC endpoint security group")
            sg_node >> sg_vpc_endpoint

            # emr/security_groups
            sg_emr_cluster = Shield("EMR cluster security group")
            sg_emr_service = Shield("EMR service security group")
            sg_emr_cluster >> sg_emr_service >> sg_emr_cluster

        nat_gw = NATGateway("NAT gateway (1/AZ)")
        eip = EC2ElasticIpAddress("Elastic IP Address (1/AZ)")
        ig = InternetGateway("Internet Gateway")

        private_subnet >> nat_gw >> eip
        emr_private_subnet >> nat_gw >> eip
        public_subnet >> ig >> public_subnet

    tecton >> ca_iam_role
