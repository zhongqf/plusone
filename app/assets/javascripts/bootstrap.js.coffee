jQuery ->
  $(".alert-message").alert()
  $(".tabs").button()
  $(".carousel").carousel()
  $(".collapse").collapse()
  $(".dropdown-toggle").dropdown()
  #$(".modal").modal()
  $("a[rel]").popover()
  $(".navbar").scrollspy()
  $(".tab").tab "show"
  $(".tooltip").tooltip()
  $(".typeahead").typeahead() 

  $('[data-toggle="modal"]').on 'click', (e)->
    e.preventDefault()
    href = $(this).attr("href")
    modal = $(this).attr("data-modal")
    if href.indexOf('#') == 0
      $(modal).modal('open')
    else
      $.get(href, (data)->
        $(modal).addClass("modal fade hide")
        $(modal).html(data)
        $(modal).modal()
      ).success -> $('input:text:visible:first').focus()