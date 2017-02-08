# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".full-content-container").click (window.event), ->
			window.location.href = "/";

		$(".full-content").click (window.event), ->
			window.event.stopPropagation()

		$("span.dismiss-modal").click (window.event), ->
			modal = $('body').find(".modal-container")
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			modal.hide()

		$(".modal-container").click (window.event), ->
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			$(@).hide()

		$(".modal-content").click (window.event), ->
			window.event.stopPropagation()

		$(".login-modal-cta").click (window.event), ->
			loginModal = $('body').find(".modal-container#login-form")
			loginModal.find("input#user_email").focus()
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			loginModal.fadeIn()

		$(".join-modal-cta").click (window.event), ->
			joinModal = $('body').find(".modal-container#join-form")
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			joinModal.fadeIn()

		$(".account-settings-modal").click (window.event), ->
			settingsModal = $('body').find(".modal-container#settings")
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			settingsModal.fadeIn()


		$("#basic-option").click (window.event), ->
			$('body').find('#cancel-account').hide()
			$('body').find('form#payments').hide()
			$('body').find('form#basic').show()
			window.event.preventDefault()

		$("#payment-option").click (window.event), ->
			$('body').find('form#basic').hide()
			$('body').find('#cancel-account').hide()
			$('body').find('form#payments').show()
			window.event.preventDefault()

		$("#cancel-option").click (window.event), ->
			$('body').find('form#basic').hide()
			$('body').find('form#payments').hide()
			$('body').find('#cancel-account').show()
			window.event.preventDefault()

		$(".update-profile").click (window.event), ->
			thisForm = $(@).parent().parent().parent()
			mainForm = thisForm.find('.main-form')
			confirmForm = thisForm.find('.confirm-form')
			mainForm.hide()
			confirmForm.show()

		$("a.tabular-option").click (event), ->
			$(@).parent().parent().parent().find('a.active').removeClass('active')
			$(@).addClass('active')

		$('.new-post-cta').click (event), ->
			$('body').find("#post-form").show()
			$('body').find('.content').addClass('blurred')
			$('body').addClass('no-scroll')

		$(".dashboard-profile.clickable").click (window.event), ->
			$(@).children(".dashboard-profile-content").slideToggle()

		$(".dashboard-profile-content").click (window.event), ->
			window.event.stopPropagation()

		$(".subscribe-cta").click (window.event), ->
			followingID = $(@).data('following-id')
			$me = $(@)
			$.ajax
				url: "/user/follow/#{followingID}"
				type: "GET"
				success: (data) ->
			  		console.log(data)
			  		if data.now_following
			  			$me.text("Following")
			  			$me.addClass('following')
			  		else
			  			$me.text("Follow")
			  			$me.removeClass('following')
		
		$(".follow-community-cta").click (window.event), ->
			followingID = $(@).data('following-id')
			$me = $(@)
			all_follow_ctas = $('body').find('.follow-community-cta')
			$.ajax
				url: "/user/community/follow/#{followingID}"
				type: "GET"
				success: (data) ->
			  		console.log(data)
			  		if data.now_following
			  			all_follow_ctas.addClass('following')
			  		else
			  			all_follow_ctas.removeClass('following')
		
		$(".follow-community-from-list").click (window.event), ->
			followingID = $(@).data('following-id')
			$me = $(@)
			$.ajax
				url: "/user/community/follow/#{followingID}"
				type: "GET"
				success: (data) ->
			  		console.log(data)
			  		if data.now_following
			  			$me.addClass('following')
			  		else
			  			$me.removeClass('following')

		$(".profile-header-option").click (window.event), ->
			$('body').find('.profile-header-option.active').removeClass("active")
			$(@).addClass("active")
			if $(@).data('option-type') == "posts"
				$('body').find('.column-content#column_content_posts').fadeIn()
				$('body').find('.column-content#column_content_works').hide()
				$('body').find('.column-content#column_content_new').hide()
				$('body').find('.column-content#column_content_comments').hide()	
				$('body').find('.column-content#column_content_subscribers').hide()
				$('body').find('.column-content#column_content_communities').hide()
			else if $(@).data('option-type') == "subscribers"
				$('body').find('.column-content#column_content_subscribers').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_works').hide()
				$('body').find('.column-content#column_content_communities').hide()
				$('body').find('.column-content#column_content_comments').hide()
			else if $(@).data('option-type') == "works"
				$('body').find('.column-content#column_content_works').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_subscribers').hide()
				$('body').find('.column-content#column_content_communities').hide()
			else if $(@).data('option-type') == "communities"
				$('body').find('.column-content#column_content_communities').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_subscribers').hide()	
			else if $(@).data('option-type') == "new"
				$('body').find('.column-content#column_content_new').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_subscribers').hide()
			else if $(@).data('option-type') == "comments"
				$('body').find('.column-content#column_content_comments').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_subscribers').hide()		

		$('input.dashboard-post-input').on 'focusin', (window.event), ->
			submitButton = $(@).parent().find('.dashboard-post-submit')
			submitButton.show()

		$('input.dashboard-post-input').on 'focusout', (window.event), ->
			postText = $(@).val()
			if postText.length == 0
				submitButton = $(@).parent().find('.dashboard-post-submit')
				submitButton.hide()
			end

		$('a.comment-cta-modal').click (window.event), ->
			$('body').find('.modal-container#comment-form').show()
			$('body').find('.content').addClass('blurred')
			$('body').addClass('no-scroll')

		$('button.navbar-toggle.menu').click (window.event), ->
			$('body').find("#sidebar-nav").show()
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')

		$('a.dropdown-toggle').click (window.event), ->
			$('body').find("#sidebar-nav").show()
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')

		$('.sidebar').click (window.event), ->
			window.event.stopPropagation()

		$('span.post').click (window.event), ->
			$('body').find("#post-form").show()
			$('body').find('.content').addClass('blurred')
			$('body').addClass('no-scroll')

		$('button.navbar-toggle.right').click (window.event), ->
			$('body').find("#post-form").show()
			$('body').find('.content').addClass('blurred')
			$('body').addClass('no-scroll')

		$('.comment-reply-cta').click (window.event), ->
			$(@).parent().next(".comment-response").show()

		$('span.up-vote-enabled').click (window.event), ->
			post_id = $(@).data('post-id')
			me = $(@)
			down_vote = $(@).parent().parent().find('.down-vote')
			$.ajax
				url: "/post/#{post_id}/up_vote", format: 'js'
				type: "GET"
				success: (data) ->
					console.log(data)
					if data.change
						voteCounter = me.parent().parent().find('.vote-count')
						count = parseInt(voteCounter.text(), 10) + data.change
						voteCounter.text(count)
						me.toggleClass('active')
						if data.change == 2
							down_vote.removeClass('active')

		$('span.down-vote-enabled').click (window.event), ->
			post_id = $(@).data('post-id')
			me = $(@)
			up_vote = $(@).parent().parent().find('.up-vote')
			$.ajax
				url: "/post/#{post_id}/down_vote", format: 'js'
				type: "GET"
				success: (data) ->
					console.log(data)
					if data.change
						voteCounter = me.parent().parent().find('.vote-count')
						count = parseInt(voteCounter.text(), 10) + data.change
						voteCounter.text(count)
						me.toggleClass('active')
						if data.change == -2
							up_vote.removeClass('active')

		$("span.up-vote-disabled").click (window.event), ->
			joinModal = $('body').find(".modal-container#join-form")
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			joinModal.fadeIn()

		$("span.down-vote-disabled").click (window.event), ->
			joinModal = $('body').find(".modal-container#join-form")
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			joinModal.fadeIn()

		$('span.comment-up-vote-cta').click (window.event), ->
			comment_id = $(@).data('comment-id')
			me = $(@)
			down_vote = $(@).parent().find('.comment-down-vote')
			$.ajax
				url: "/comment/#{comment_id}/up_vote", format: 'js'
				type: "GET"
				success: (data) ->
					console.log(data)
					if data.change
						voteCounter = me.parent().find('.vote-count')
						count = parseInt(voteCounter.text(), 10) + data.change
						voteCounter.text(count)
						me.toggleClass('active')
						if data.change == 2
							down_vote.removeClass('active')

		$('span.comment-down-vote-cta').click (window.event), ->
			comment_id = $(@).data('comment-id')
			me = $(@)
			up_vote = $(@).parent().find('.comment-up-vote')
			$.ajax
				url: "/comment/#{comment_id}/down_vote", format: 'js'
				type: "GET"
				success: (data) ->
					console.log(data)
					if data.change
						voteCounter = me.parent().find('.vote-count')
						count = parseInt(voteCounter.text(), 10) + data.change
						voteCounter.text(count)
						me.toggleClass('active')
						if data.change == -2
							up_vote.removeClass('active')

		$('p.post-type').click (window.event), ->
			$(@).parent().hide()
			$('.post-modal-form').fadeIn()

		$('p.post-type#link').click (window.event), ->
			$('.form-header#link').show()
			$('input.new-post-submit')

		$('p.post-type#photo').click (window.event), ->
			$('.form-header#photo').show()
			$('.post-modal-form').find('input#post_url').attr("placeholder", "Link to Photo")

		$('p.post-type#discussion').click (window.event), ->
			$('.form-header#discussion').show()
			$('.post-modal-form').find('input#post_url').hide()
			$('.post-modal-form').find('input#post_title').attr("placeholder", "Topic")

		$('span.community-select-span').click (window.event), ->
			$(@).toggleClass('selected')
			checkBox = $(@).parent().find('.community-select-input')
			checkBox.prop("checked", !checkBox.prop("checked"))
		
		$('a.post-title-link').click (window.event), ->
			post_id = $(@).data('post-id')
			position = $(@).data('position')
			$.ajax
				url: "/click/#{post_id}/#{position}/", format: 'js'
				type: "GET"

$(document).on('turbolinks:load', ready)