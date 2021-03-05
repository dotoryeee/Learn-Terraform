terraform {
    backend "s3" {
      bucket         = "ljw-terra-backend" 
      key            = "terraform_source/iam/terraform.tfstate"
          # s3내 경로는 현재 경로와 일치 시키는것이 관리하기 편리합니다
      region         = "ap-northeast-2"  
      encrypt        = true
      dynamodb_table = "terraform-lock"
    }
}
