/*jslint browser: true, onevar: true, undef: true, nomen: true, eqeqeq: true,
  plusplus: true, bitwise: true, regexp: true, newcap: true, immed: true */
/*global $, window, document, navigator, google */

/* mwForum - Web-based discussion forum
Copyright (c) 1999-2011 Markus Wichitill

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version. */

var mwf = { p: $.parseJSON($("meta[name=jsparams]").attr("content")) };

$(document).ready(function () {
	var script = mwf.p.env_script;
	if (mwf.p.cfg_boardJumpList) { mwf.initBoardList(); }
	if (mwf.p.tagButtons) { mwf.initTagButtons(); }
	if (script === "topic_show") {
		mwf.initToggleBranch();
		mwf.initKeyNavigation();
		mwf.initRevealPost();
	}
	else if (script === "topic_add" || script === "post_add" || script === "post_edit") {
		mwf.initInsertRaw();
	}
	else if (script === "user_profile") { mwf.initGeolocate(); }
	else if (script === "user_info") { mwf.initGoogleMaps(); }
	else if (script === "forum_search") { mwf.initGoogleSearch(); }
	else if (script === "forum_activity") { mwf.initActivityGraph(); }
	mwf.initDataVersion();
});

$(window).load(function () {
	if (mwf.p.env_script === "topic_show") { mwf.initFocusPost(); }
	else if (!("autofocus" in document.createElement("input"))) { $(".fcs:first").focus(); }
});

mwf.navigate = function (href) {
	if (mwf.navigating) { return; }
	mwf.navigating = true;
	window.location = href;
};

mwf.initBoardList = function () {
	$("[name=bid]").change(function () {
		var ext = mwf.p.m_ext,
			sid = mwf.p.m_sessionId ? "sid=" + mwf.p.m_sessionId : "",
			id = this.options[this.selectedIndex].value;
		if (id.indexOf("cid") === 0) { mwf.navigate("forum_show" + ext + "?" + sid + "#" + id); }
		else if (id === 0) { mwf.navigate("forum_show" + ext + "?" + sid); }
		else { mwf.navigate("board_show" + ext + "?" + "bid=" + id + ";" + sid); }
	});
};

mwf.scrollToPost = function (ob) {
	mwf.currPostOb = ob;
	ob.parents(".brn:hidden").each(function () { mwf.toggleBranch(this.id.substr(3)); });
	ob.find(".psl").focus();
	window.scrollTo(0, ob.offset().top - 5);
};

mwf.initFocusPost = function () {
	$(".psl").live("focus", function () {
		$(".pst.fcp").removeClass("fcp");
		mwf.currPostOb = $(this).closest(".pst");
		mwf.currPostOb.addClass("fcp");
	});
	$(".prl, .nnl").live("click", function () {
		var href = $(this).attr("href");
		if (href.indexOf("#") === 0) {
			mwf.scrollToPost($(href));
			return false;
		}
	});
	if (mwf.p.scrollPostId > 0) {
		mwf.scrollToPost($("#pid" + mwf.p.scrollPostId));
	}
	else if (window.location.search.match(/\bfoc=last\b/)) {
		mwf.scrollToPost($(".pst:last"));
	}
	else {
		mwf.currPostOb = $(".pst:first");
		mwf.currPostOb.find(".psl").focus();
	}
};

mwf.toggleBranch = function (postId) {
	var tglObs = postId ? $("#tgl" + postId) : $(".tgl"),
		brnObs = postId ? $("#brn" + postId) : $(".brn");
	if (brnObs.is(":hidden")) {
		tglObs.removeClass("sic_nav_plus").addClass("sic_nav_minus").
			attr({ title: mwf.p.lng_tpcBrnCollap, alt: "-" });
		if (postId) { brnObs.slideDown(); }
		else { brnObs.show(); }
	}
	else {
		tglObs.removeClass("sic_nav_minus").addClass("sic_nav_plus").
			attr({ title: mwf.p.lng_tpcBrnExpand, alt: "+" });
		if (postId) { brnObs.slideUp(); }
		else { brnObs.hide(); }
	}
};

mwf.initToggleBranch = function () {
	$(".brn.clp").hide();
	$(".tgl").live("click", function (ev) {
		if (ev.shiftKey) { mwf.toggleBranch(); }
		else { mwf.toggleBranch(this.id.substr(3)); }
	});
};

mwf.initKeyNavigation = function () {
	$(document).keydown(function (ev) {
		var key, obs, ob, i, href;
		if (ev.ctrlKey || $(ev.target).is("input, textarea, select")) { return; }
		if (ev.which === 106) { mwf.toggleBranch(); }
		key = String.fromCharCode(ev.which);
		if (key === "W") {
			obs = $(".pst:visible");
			if ((i = obs.index(mwf.currPostOb)) > 0) {
				mwf.scrollToPost(obs.eq(i - 1));
			}
			else if ((obs = $(".sic_nav_prev")).length === 4) {
				mwf.navigate(obs.eq(1).parent().attr("href") + ";foc=last");
			}
		}
		else if (key === "S") {
			obs = $(".pst:visible");
			if ((i = obs.index(mwf.currPostOb)) >= 0 && i + 1 < obs.length) {
				mwf.scrollToPost(obs.eq(i + 1));
			}
			else if ((obs = $(".sic_nav_next")).length === 4) {
				mwf.navigate(obs.eq(1).parent().attr("href"));
			}
		}
		else if (key === "A") {
			if (mwf.currPostOb.next().is(".brn:visible")) {
				mwf.toggleBranch(mwf.currPostOb.attr("id").substr(3));
			}
			else if ((ob = mwf.currPostOb.find(".sic_nav_up")).length) {
				href = ob.parent().attr("href");
				if (href && href.indexOf("#") === 0) {
					mwf.scrollToPost($("#pid" + href.substr(4)));
				}
				else if (href) {
					mwf.navigate(href);
				}
			}
		}
		else if (key === "D") {
			if (mwf.currPostOb.next(".brn:hidden").length) {
				mwf.toggleBranch(mwf.currPostOb.attr("id").substr(3));
			}
			else if (mwf.currPostOb.next(".brn").length) {
				mwf.scrollToPost(mwf.currPostOb.next().find(".pst:first"));
			}
		}
		else if (key === "E") {
			if (mwf.currPostOb.is(".new, .unr")) {
				obs = $(".pst.new, .pst.unr");
				if ((i = obs.index(mwf.currPostOb)) >= 0 && i + 1 < obs.length) {
					mwf.scrollToPost(obs.eq(i + 1));
				}
				else if ((ob = mwf.currPostOb.find(".sic_post_nn")).length) {
					mwf.navigate(ob.parent().attr("href"));
				}
			}
			else {
				if ((ob = $(".pst.new, .pst.unr").first()).length) {
					mwf.scrollToPost(ob);
				}
				else if ((ob = $(".sic_post_nn:first")).length) {
					mwf.navigate(ob.parent().attr("href"));
				}
			}
		}
	});
};

mwf.initRevealPost = function () {
	$(".frm.pst.ign").live("click", function () {
		$(this).find(".bcl").show();
		$(this).find(".ccl").slideDown();
	});
};

mwf.insertTags = function (tag1, tag2) {
	var range, sel, scroll, start, end, before, after, caret,
		el = $(".tgi")[0];
	el.focus();
	if (document.selection) {
		range = document.selection.createRange();
		sel = range.text;
		range.text = tag2 ? "[" + tag1 + "]" + sel + "[/" + tag2 + "]" : ":" + tag1 + ":";
		range = document.selection.createRange();
		if (tag2 && !sel.length) { range.move("character", -tag2.length - 3); }
		else if (tag2) { range.move("character", tag1.length + 2 + sel.length + tag2.length + 3); }
		range.select();
	}
	else if (typeof el.selectionStart !== "undefined") {
		scroll = el.scrollTop;
		start = el.selectionStart;
		end = el.selectionEnd;
		before = el.value.substring(0, start);
		sel = el.value.substring(start, end);
		after = el.value.substring(end, el.textLength);
		el.value = tag2 ? before + "[" + tag1 + "]" + sel + "[/" + tag2 + "]" + after :
			before + ":" + tag1 + ":" + after;
		caret = sel.length === 0 ? start + tag1.length + 2 :
			start + tag1.length + 2 + sel.length + tag2.length + 3;
		el.selectionStart = caret;
		el.selectionEnd = caret;
		el.scrollTop = scroll;
	}
};

mwf.initTagButtons = function () {
	var html, selOb,
		dlOb = $("#snippets");
	$(".tbt").live("click", function () {
		var match = this.id.match(/tbt_([a-z]+)(?:_([a-z]+))?/),
			tag1 = match[1],
			tag2 = tag1;
		if ($(this).hasClass("tbt_p")) { tag1 += "="; }
		else if (match[2]) { tag1 += "=" + match[2]; }
		mwf.insertTags(tag1, tag2);
	});
	$(".tbc").live("click", function () { mwf.insertTags(this.id.substr(4)); });
	if (!dlOb) { return; }
	html = "<option selected='selected' disabled='disabled'>" + mwf.p.lng_tbbInsSnip + "</option>";
	dlOb.children("dt").each(function () {
		html = html + "<option>" + $(this).text() + "</option>";
	});
	selOb = $("<select size='1'>" + html + "</select>").insertAfter(dlOb);
	$("<button type='button' class='snp'>+</button>").insertAfter(selOb).
		click(function () {
			var start, end, before, after,
				name = selOb.find("option:selected").text(),
				text = dlOb.find("dt:contains(" + name + ")").next().text(),
				el = $(".tgi")[0];
			el.focus();
			if (document.selection) {
				document.selection.createRange().text = text;
			}
			else if (typeof el.selectionStart !== "undefined") {
				start = el.selectionStart;
				end = el.selectionEnd;
				before = el.value.substring(0, start);
				after = el.value.substring(end, el.textLength);
				el.value = before + text + after;
			}
		});
};

mwf.initInsertRaw = function () {
	$("#rawlnk").click(function () {
		$(this).hide();
		$("#rawfld").slideDown();
	});
};

mwf.initGeolocate = function () {
	if (mwf.p.cfg_userInfoMap < 1 || !navigator.geolocation) { return; }
	$("#loc").show().click(function () {
		navigator.geolocation.getCurrentPosition(function (p) {
			$("[name=location]").val(p.coords.latitude + " " + p.coords.longitude);
		});
	});
};

mwf.initGoogleMaps = function () {
	if (!mwf.p.location) { return; }
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({ address: mwf.p.location, country: mwf.p.countryCode,
		language: mwf.p.uaLangCode }, function (results, status) {
			var txt, i, result,
				mapOb = $("#map");
			if (status !== google.maps.GeocoderStatus.OK) {
				mapOb.closest(".frm").hide();
				return;
			}
			mwf.viewport = results[0].geometry.viewport;
			if (mwf.p.location.match(/^[\s\d\.\-]+$/)) { results = results.slice(0, 1); }
			if (results[0].formatted_address) {
				txt = results[0].formatted_address;
				if (results.length > 1) {
					txt += " (" + (results.length - 1) + " " + mwf.p.lng_uifMapOthrMt + ")";
				}
				$("#loc").append(txt);
			}
			mwf.map = new google.maps.Map(mapOb[0], { mapTypeId: google.maps.MapTypeId.ROADMAP,
				center: results[0].geometry.location, zoom: 4 });
			mwf.mapMarkers = [];
			for (i = 0; (result = results[i]); i += 1) {
				mwf.mapMarkers.push(
					new google.maps.Marker({ map: mwf.map, position: result.geometry.location,
					title: result.formatted_address + " [" + result.geometry.location_type + "]" }));
			}
		}
	);
	$("#loc").click(function () { mwf.map.fitBounds(mwf.viewport); });
};

mwf.initGoogleSearch = function () {
	function googleSearch() {
		var query = $("#gSearchQuery").val();
		if (!query.length) { return; }
		query += " site:" + mwf.p.siteSearch;
		$("#gSearchMore, #gSearchNotFound").hide();
		$("#gSearching").show();
		$.getJSON("http://ajax.googleapis.com/ajax/services/search/web?callback=?",
			{ v: "1.0", rsz: 8, safe: "off", start: mwf.googleSearchStart, q: query },
			function (json) {
				var cursor, results, filter,
					resultsOb = $("#gSearchResults");
				$("#gSearching").hide();
				if (!json.responseData) { return; }
				cursor = json.responseData.cursor;
				results = json.responseData.results;
				filter = mwf.p.cfg_seoRewrite === 0 ? /topic_show/ : /topic_\d+_\d+\.html/;
				$.each(results, function (i) {
					var index = mwf.googleSearchStart + i + 1;
					if (!this.unescapedUrl.match(filter)) { return; }
					$("<div class='frm pst'><div class='hcl'><span class='htt'>" + index +
						".</span> <a href='" + this.unescapedUrl + "' target='_blank'>" + this.title +
						"</a></div><div class='ccl'>" + this.content + "</div></div>").
						appendTo(resultsOb);
				});
				if (!cursor.currentPageIndex && !results.length) { $("#gSearchNotFound").show(); }
				else if (cursor.currentPageIndex + 1 < cursor.pages.length) { $("#gSearchMore").show(); }
			}
		);
	}
	$("#gSearchForm").submit(function () {
		$(".frm.pst").remove();
		mwf.googleSearchStart = 0;
		googleSearch();
		return false;
	});
	$("#gSearchMore").click(function () {
		mwf.googleSearchStart += 8;
		googleSearch();
	});
};

mwf.initDataVersion = function () {
	$(".cpr").dblclick(function () {
		$.post("ajax_dataversion" + mwf.p.m_ext, { foo: "bar" }, function (json) {
			$(".cpr:first").after("<p class='cpr'>" + (json.error || json.dataVersion) + "</p>");
		});
	});
};

mwf.initActivityGraph = function () {
	var y, yi, d, v, grad,
		canvasEl = $("canvas")[0],
		ctx = canvasEl.getContext("2d"),
		h = canvasEl.height,
		stats = $.parseJSON($("#postsPerDay").text());
	ctx.font = "9px sans-serif";
	ctx.textBaseline = "top";
	for (y = mwf.p.firstYear, yi = 0; y <= mwf.p.lastYear; y += 1, yi += 1) {
		ctx.fillStyle = "#f00";
		ctx.fillRect(yi * 365, 0, 1, h);
		ctx.fillText(y, yi * 365 + 3, 0);
		for (d = 0; d < 365; d += 1) {
			if ((v = stats[y + "." + d])) {
				grad = ctx.createLinearGradient(0, h - v, 0, h);
				grad.addColorStop(0, "#ccf");
				grad.addColorStop(1, "#00f");
				ctx.fillStyle = grad;
				ctx.fillRect(yi * 365 + d, h - v, 1, v);
			}
		}
	}
};
