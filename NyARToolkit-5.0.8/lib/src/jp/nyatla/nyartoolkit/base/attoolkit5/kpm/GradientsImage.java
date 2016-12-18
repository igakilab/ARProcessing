/* 
 * PROJECT: NyARToolkit
 * --------------------------------------------------------------------------------
 * This work is based on the original ARToolKit developed by
 *  Copyright 2013-2015 Daqri, LLC.
 *  Author(s): Chris Broaddus
 *
 * The NyARToolkit is Java edition ARToolKit class library.
 *  Copyright (C)2016 Ryo Iizuka
 * 
 * NyARToolkit is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as publishe
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * NyARToolkit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * As a special exception, the copyright holders of this library give you
 * permission to link this library with independent modules to produce an
 * executable, regardless of the license terms of these independent modules, and to
 * copy and distribute the resulting executable under terms of your choice,
 * provided that you also meet, for each linked independent module, the terms and
 * conditions of the license of that module. An independent module is a module
 * which is neither derived from nor based on this library. If you modify this
 * library, you may extend this exception to your version of the library, but you
 * are not obligated to do so. If you do not wish to do so, delete this exception
 * statement from your version.
 * 
 */
package jp.nyatla.nyartoolkit.base.attoolkit5.kpm;

import jp.nyatla.nyartoolkit.core.NyARRuntimeException;
import jp.nyatla.nyartoolkit.core.raster.INyARRaster;
import jp.nyatla.nyartoolkit.core.types.NyARBufferType;
import jp.nyatla.nyartoolkit.core.types.NyARIntSize;

public class GradientsImage implements INyARRaster{
	private NyARIntSize _size;
	private double[] _buf;
	public GradientsImage(int i_width, int i_height)
	{
		this._size=new NyARIntSize(i_width,i_height);
		this._buf=new double[i_width*i_height*2];
	}
	@Override
	public int getWidth() {
		return this._size.w;
	}

	@Override
	public int getHeight() {
		return this._size.h;
	}

	@Override
	public NyARIntSize getSize() {
		return this._size;
	}

	@Override
	public Object getBuffer() {
		return this._buf;
	}

	@Override
	public int getBufferType() {
		return NyARBufferType.USER_DEFINE;
	}

	@Override
	public boolean isEqualBufferType(int i_type_value)
	{
		return false;
	}

	@Override
	public boolean hasBuffer() {
		return true;
	}

	@Override
	public void wrapBuffer(Object i_ref_buf) {
		NyARRuntimeException.notImplement();
	}

	@Override
	public Object createInterface(Class<?> i_iid)
	{
		throw new NyARRuntimeException();
	}
	
	//これどうにかしよう
	public int get(int i_row) {
		return this._size.w*i_row*2;
	}

}
