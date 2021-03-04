resource "aws_iam_group" "test_group"{
	name = "terra_group"
}

resource "aws_iam_group_membership" "terra_group"{
	name = aws_iam_group.test_group.name

	users = [
		aws_iam_user.gildong_hong.name
	]
	
	group = aws_iam_group.test_group.name
}
