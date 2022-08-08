#!/bin/env python3

from diagrams import Cluster, Diagram, Edge
from diagrams.aws.storage import S3
from diagrams.aws.security import IAM
from diagrams.custom import Custom

diagram_attr = {
    "pad": "0.25"
}

with Diagram("Tecton SaaS Deployment", graph_attr=diagram_attr, filename="diagram"):
    tecton = Edge(Custom("Tecton", "../../resources/tecton-red-on-blue.png"))

    with Cluster("Customer owned AWS Account - Tecton Dataplane"):
        # common saas
        S3("Tecton S3 bucket")
        with Cluster("IAM"):
            ca_iam_role = IAM("Cross-account role")
            IAM("Spot service-linked role")

    tecton >> ca_iam_role
