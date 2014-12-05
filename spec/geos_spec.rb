describe 'Geos' do

  context 'with GEOS_LIBRARY_PATH set' do
    before do
      begin
        geos_library_paths = `geos-config --libs`
        path = geos_library_paths.split(' ').first.gsub('-L', '')
        ENV['GEOS_LIBRARY_PATH'] = path
      rescue
        abort('Must have a Geos library installed.')
      end
    end

    it 'should load correctly' do
      expect{ load 'ffi-geos.rb' }.not_to  raise_exception
    end
  end

  context 'without GEOS_LIBRARY_PATH set' do
    before do
      ENV.delete 'GEOS_LIBRARY_PATH'
      Object.send(:remove_const, :Geos)
    end
    it 'should load correctly' do
      expect{ load 'ffi-geos.rb' }.not_to  raise_exception
    end
  end

end
