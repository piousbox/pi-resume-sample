
describe "Galleries", ->

  beforeEach ->
    a = $("<div>").attr('id', 'main')
    b = $("<div>").addClass('index')
    a.append b
    $('body').append a

  afterEach ->
    # $("#main").remove()

  describe "models", ->
    it 'defines models for galleries, gallery', ->
      galleries = new Models.ManagerGalleries()
      expect( galleries ).toBeDefined()
      gallery = new Models.ManagerGallery({ 'galleryname': 'Aaa' })
      expect( gallery ).toBeDefined()





