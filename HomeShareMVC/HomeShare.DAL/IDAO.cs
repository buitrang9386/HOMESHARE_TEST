using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    interface IDAO<T>
    {
        T create(T obj);
        T read(int id);
        List<T> readAll();
        T update(T obj);
        void delete(int id);
    }
}
