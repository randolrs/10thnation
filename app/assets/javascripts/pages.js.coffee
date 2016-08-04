# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".full-content-container").click (event), ->
			window.location.href = "/";

		$(".full-content").click (event), ->
			event.stopPropagation()

		$("span.dismiss-modal").click (event), ->
			modal = $('body').find(".modal-container")
			contentContainer = $('body').find(".content-container")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			modal.hide()

		$(".modal-container").click (event), ->
			contentContainer = $('body').find(".content-container")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			$(@).hide()

		$(".modal-content").click (event), ->
			event.stopPropagation()

		$(".login-modal-cta").click (event), ->
			loginModal = $('body').find(".modal-container#login-form")
			loginModal.find("input#user_email").focus()
			contentContainer = $('body').find(".content-container")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			loginModal.fadeIn()

		$(".join-modal-cta").click (event), ->
			joinModal = $('body').find(".modal-container#join-form")
			contentContainer = $('body').find(".content-container")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			joinModal.fadeIn()

		$("#upload-track-cta").click (event), ->
			trackModal = $('body').find(".modal-container#upload-track-form")
			contentContainer = $('body').find(".content-container")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			trackModal.fadeIn()

		$(".account-settings-modal").click (event), ->
			settingsModal = $('body').find(".modal-container#settings")
			contentContainer = $('body').find(".content-container")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			settingsModal.fadeIn()

		$(".option-item").click (event), ->
			$('body').find('.option-item.active').removeClass("active")
			$(@).addClass("active")

		$(".content-panel.tracks").click (event), ->
			$('body').find('.audio-player').show()

		$("#basic-option").click (event), ->
			$('body').find('#cancel-account').hide()
			$('body').find('form#payments').hide()
			$('body').find('form#basic').show()
			event.preventDefault()

		$("#payment-option").click (event), ->
			$('body').find('form#basic').hide()
			$('body').find('#cancel-account').hide()
			$('body').find('form#payments').show()
			event.preventDefault()

		$("#cancel-option").click (event), ->
			$('body').find('form#basic').hide()
			$('body').find('form#payments').hide()
			$('body').find('#cancel-account').show()
			event.preventDefault()

		$(".update-profile").click (event), ->
			thisForm = $(@).parent().parent().parent()
			mainForm = thisForm.find('.main-form')
			confirmForm = thisForm.find('.confirm-form')
			mainForm.hide()
			confirmForm.show()

		$(".content").click (event), ->
			audioContainer = $('body').find('.audio-player')
			audioPlayer = audioContainer.find('audio.audio-player-object')
			audioHeader = audioContainer.find('h3.audio-player-header')
			audioFunctions = audioContainer.find('.audio-functions')
			if audioContainer.is(":visible")
				audioPlayer.trigger('pause')
				audioHeader.addClass("clickable")
				audioFunctions.slideUp()

		$("h3.audio-player-header").click (event), ->
			audioContainer = $('body').find('.audio-player')
			audioPlayer = audioContainer.find('audio.audio-player-object')
			audioFunctions = audioContainer.find('.audio-functions')
			audioFunctions.slideDown()
			audioPlayer.trigger('play')

		$("div.content-panel.tracks").click (event), ->
			audioContainer = $('body').find('.audio-player')
			audioFunctions = audioContainer.find('.audio-functions')
			audioFunctions.show()

		$("a.tabular-option").click (event), ->
			$(@).parent().parent().parent().find('a.active').removeClass('active')
			$(@).addClass('active')

		$("a#new-post").click (event), ->
			$('body').find("#post-form").show()
			$('body').find('.content-container').addClass('blurred')
			$('body').addClass('no-scroll')

		$(".dashboard-profile.clickable").click (event), ->
			$(@).children(".dashboard-profile-content").slideToggle()

		$(".dashboard-profile-content").click (event), ->
			event.stopPropagation()

		$(".subscribe-cta").click (event), ->
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
		
		$(".follow-community-cta").click (event), ->
			followingID = $(@).data('following-id')
			alert("alert")
			$me = $(@)
			$.ajax
				url: "/user/community/follow/#{followingID}"
				type: "GET"
				success: (data) ->
			  		console.log(data)
			  		if data.now_following
			  			$me.text("Following")
			  			$me.addClass('following')
			  		else
			  			$me.text("Follow")
			  			$me.removeClass('following')

		$(".profile-header-option").click (event), ->
			$('body').find('.profile-header-option.active').removeClass("active")
			$(@).addClass("active")
			if $(@).data('option-type') == "posts"
				$('body').find('.column-content#column_content_posts').fadeIn()
				$('body').find('.column-content#column_content_works').hide()
				$('body').find('.column-content#column_content_subscribers').hide()
				$('body').find('.column-content#column_content_communities').hide()
			else if $(@).data('option-type') == "subscribers"
				$('body').find('.column-content#column_content_subscribers').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_works').hide()
				$('body').find('.column-content#column_content_communities').hide()
			else if $(@).data('option-type') == "works"
				$('body').find('.column-content#column_content_works').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_subscribers').hide()
				$('body').find('.column-content#column_content_communities').hide()
			else if $(@).data('option-type') == "communities"
				$('body').find('.column-content#column_content_communities').fadeIn()
				$('body').find('.column-content#column_content_posts').hide()
				$('body').find('.column-content#column_content_subscribers').hide()		

		$('input.dashboard-post-input').on 'focusin', (event), ->
			submitButton = $(@).parent().find('.dashboard-post-submit')
			submitButton.show()

		$('input.dashboard-post-input').on 'focusout', (event), ->
			postText = $(@).val()
			if postText.length == 0
				submitButton = $(@).parent().find('.dashboard-post-submit')
				submitButton.hide()
			end

		$('img.small-post-image').width($('img.small-post-image').height());

		$('a.comment-cta').click (event), ->
			$('body').find('.modal-container#comment-form').show()

$(document).ready(ready)
$(document).on('page:load', ready)