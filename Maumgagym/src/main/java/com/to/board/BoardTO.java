package com.to.board;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BoardTO {
	
	int seq;
	int category_seq;
	String title;
	String content;
	int write_seq;
	String write_date;
	String status;
	String tag;
	int view_count;
	int like_count;
	String image;
	double image_size;
	String membership_name;
	int membership_price;
	int membership_period;

}
